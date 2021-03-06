module Hicube
  class BaseController < Hicube::ApplicationController

    # Skip the before filter so we can insert it in the correctly place to preserve order.
    # skip_around_filter :audit_trail

    before_action :authenticate_user!
    before_filter :initialise_current_user

    # around_filter :audit_trail
    helper_method :current_account

    # layout 'application'


    #
    # Private Instance Methods
    #
    private

    def initialise_current_user
      return unless user_signed_in?
      User.current = current_user
    end

    def current_account
      Hicube::Account.find_by(domain: request.host_with_port)
    end

    # Check resource params are present based on the current controller name.
    def check_resource_params(options = {})

      # Determine the name based on the current controller if not specified.
      resource_name = options[:name] || controller_name.singularize

      # Determine the class based on the resource name if not provided.
      #FIXME: Do not hardcode engine name
      resource_class = options[:class] || "Hicube::#{resource_name.singularize.camelize}".classify.constantize
      

      unless params.key?(resource_name)
        notify :error, ::I18n.t('messages.resource.missing_parameters',
          :type     => resource_class.model_name.human
        )

        case action_name.to_sym
        when :create
          redirect_to :action => :new
        when :update
          redirect_to :action => :edit, :id => params[:id]
        else
          redirect_to :action => :index
        end
      end
    end

    # Load the relevant resource based on the current controller name.
    def load_resource(options = {})

      # Determine the name based on the current controller if not specified.
      resource_name = options[:name] || controller_name.singularize

      # Determine the class based on the resource name if not provided.
      # FIXME: Do not hard code engine name 
      resource_class = options[:class] || "Hicube::#{resource_name.singularize.camelize}".classify.constantize

      resource = if resource_class == Hicube::Account
        # resource = Hicube::Account.first
        current_account
      else
        # resource = resource_class.unscoped.find(params[:id])
        resource_class.unscoped.where(account: current_account).find(params[:id])
      end
      # # Confirm current user has permission to view resource.
      # unless resource.account == current_account
      #   # TODO: log an audit event.

      #   # SECURITY RISK: The user should not be able to distinguish between a
      #   # non-existant resource and another user's resource. This way you can't
      #   # probe to the system and determine another account's data.
      #   raise Mongoid::Errors::DocumentNotFound.new(resource_class, :id => params[:id])
      # end

      # Set an instance variable @resource_name to the resource.
      instance_variable_set("@#{resource_name}", resource)

      rescue Mongoid::Errors::DocumentNotFound => e
      notify :error, ::I18n.t('messages.resource.not_found',
        :type     => resource_class.model_name.human,
        :criteria => resource_class.human_attribute_name(:id),
        :value    => params[:id]
      )
      redirect_to :action => :index
    end

    # Load all relevant resources based on the current controller name.
    def load_resources(options = {})

      # Determine the name based on the current controller if not specified.
      resource_name = options[:name] || controller_name.pluralize

      # Set an instance variable @name to contain the names for this user.
      #FIXME: Do not hard code Hicube here
      instance_variable_set("@#{resource_name}", "Hicube::#{resource_name.singularize.camelize}".classify.constantize.unscoped.where(account: current_account).all)
    end

    # def setup_account!
    #   case 
    #   when current_user.account.nil?
    #     if current_user.sign_in_count == 1
    #       logger.debug "Account not present, first login so show edit account page."
    #       notify :success, "Almost done! Please complete #{Account.model_name.human.downcase} setup before proceeding."
    #       redirect_to new_users_settings_account_path # if current_user.account.nil?
    #     else
    #       logger.debug "Account not present, returning user so show edit account page."
    #       notify :warning, "Please complete #{Account.model_name.human.downcase} setup before proceeding."
    #       redirect_to (current_user.account.nil? ? new_users_settings_account_path : edit_users_settings_account_path) # if current_user.account.nil?
    #     end
    #   when Subscriber.by_account(current_user.account).count > current_user.account.allowance
    #     logger.debug "Allowance Breached. Current allowance = #{current_user.account.allowance} & Subscriber count = #{Subscriber.by_account(current_user.account).count}"
    #     notify :error, "You have more subscribers in your database than allowed under your plan. Please update subscription before proceeding."
    #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
    #   end
    

    #   # if current_user.account.nil? or (Subscriber.by_account(current_user.account).count > current_user.account.allowance)
    #   #   if current_user.sign_in_count == 1
    #   #     notify :success, "Almost done! Please complete #{Account.model_name.human.downcase} setup before proceeding."
    #   #     redirect_to new_users_settings_account_path # if current_user.account.nil?
    #   #   elsif Subscriber.by_account(current_user.account).count > current_user.account.allowance
    #   #     notify :error, "You have more subscribers in your database than allowed under your plan. Please update subscription before proceeding."
    #   #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
    #   #   else
    #   #     notify :warning, "Please complete #{Account.model_name.human.downcase} setup before proceeding."
    #   #     redirect_to edit_users_settings_account_path # if current_user.account.nil?
    #   #   end
        
    #   # end
    # end

    # FIXME: CSRF token authenticity should not be overridden for JSON anymore in Rails 4?
    # This is to avoid warning - Can't verify CSRF token authenticity.
    # def verified_request?
    #   if request.content_type == "application/json"
    #     true
    #   else
    #     super()
    #   end
    # end

  end
end
