require_dependency "hicube/application_controller"

module Hicube
  class AccountsController < BaseController

    before_action :load_resource, except: [
      :create,
      :index,
      :new
    ]

    before_filter :load_resources, :only => [
      :index,
    ]

    # Must be called after load_recource filter.
    before_filter :check_resource_params, :only => [
      :create,
      :update,
    ]

    def create
      @account = Hicube::Account.new(accounts_params)
      @account.save!

      respond_to do |format|
        notify :notice, ::I18n.t('messages.resource.created',
          :type       => Hicube::Account.model_name.human,
          :resource   => @account
        )
        format.html { redirect_to action: :show, id: @account }
      end
    rescue Mongoid::Errors::Validations => e
      respond_to do |format|
        notify_now :error, ::I18n.t('messages.resource.not_valid',
          :type     => Hicube::Account.model_name.human,
          :errors   => @account.errors.full_messages.to_sentence
        )
        format.html { render :action => :new, :status => 422 }
      end
    end

    def update
      @account.update_attributes(accounts_params)
      @account.save!

      notify :notice, ::I18n.t('messages.resource.updated',
        :type       => Hicube::Account.model_name.human,
        :resource   => @account
      )
      render action: :show, id: @account
    rescue Mongoid::Errors::Validations => e
      notify_now :error, ::I18n.t('messages.resource.not_valid',
        :type     => Hicube::Account.model_name.human,
        :errors   => @account.errors.full_messages.to_sentence
      )
      render :action => :edit
    end

    private

    def accounts_params
      params.require(:account).permit(:ga, :domain, :notify_email_html, :notify_email_text)
    end
  end
end
