module Hicube
  class Public::BaseController < Hicube::ApplicationController

    layout 'hicube'

    before_action :authenticate_user!, except: [:show, :mail]
    before_filter :initialise_current_user, except: [:show]

    helper_method :current_account

    def initialise_current_user
      return unless user_signed_in?
      User.current = current_user
    end

    def current_account
      Hicube::Account.find_by(domain: request.host_with_port)
    end

    def permit_resource_params
      resource = controller_name.singularize.to_sym
      method = "#{resource}_params"
      params[resource] &&= send(method) if respond_to?(method, true)
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
      # resource = resource_class.unscoped.find((params.has_key?(:id) ? params[:id] : 'index'))
      resource = if params.has_key?(:id)
        current_account.pages.unscoped.find(params[:id])
      else
        current_account.pages.unscoped.first
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
      redirect_to '/404.html'
    end

    # Load all relevant resources based on the current controller name.
    def load_resources(options = {})

      # Determine the name based on the current controller if not specified.
      resource_name = options[:name] || controller_name.pluralize

      # Set an instance variable @name to contain the names for this user.
      #FIXME: Do not hard code Hicube here
      instance_variable_set("@#{resource_name}", "Hicube::#{resource_name.singularize.camelize}".classify.constantize.all)
    end
  end
end
