Rails.application.routes.draw do

  #mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    #get 'forget', to: 'users/passwords#forget'
    #patch 'update_password', to: 'users/passwords#update_password'
    #post '/login_validate', to: 'users/sessions#user_validate'
    #
    #unauthenticated :user do
    #  root to: "devise/sessions#new",as: :unauthenticated_root #设定登录页为系统默认首页
    #end
    #authenticated :user do
    #  root to: "homes#index",as: :authenticated_root #设定系统登录后首页
    #end
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'


  resources :properties do
  end
  resources :nests do
  end
  resources :domains do
  end

  resources :controls, :only => [:index]
  resources :templates do
    get :produce, :on => :member
  end

  resources :nlps do
    collection do
      post 'analyze'
    end
  end

  resources :notices
  resources :articles do
    get :export, :on => :collection
    get :main_image, :on => :member
    get :detail_image, :on => :member
  end

  resources :ocrs do
    post :analyze, :on => :collection
  end



  resources :statistics do
    get :line, :on => :member
    get :series, :on => :member
    get :column, :on => :member
    get :pie, :on => :member
    get :bar, :on => :member
    get :area, :on => :member
    get :scatter, :on => :member
  end

  resources :systems, :only => [] do
    get :send_confirm_code, :on => :collection
  end

  resources :users, :only => []  do
    get :center, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
    get :mobile_authc_new, :on => :member
    post :mobile_authc_create, :on => :member
    get :mobile_authc_status, :on => :member
  end

  resources :orders, :only => [:new, :create] do
    get :pay, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
  end

  resources :tasks, :only => [] do
    get :invite, :on => :collection
  end

  resources :accounts, :only => [:edit, :update] do
    get :recharge, :on => :collection 
    get :info, :on => :collection
    get :status, :on => :collection
  end

  resources :roles

  resources :spiders do
    get :start, :on => :member
  end
  resources :selectors

  resources :ctg_mtrls, :only => [] do
    get :list, :on => :collection
    get :ctg_xls_download, :on => :collection
    post :parse_excel, :on => :collection
  end
  resources :ctg_frsts do
    resources :ctg_secds do
      resources :ctg_mtrls do
      end
    end
  end

  resources :input_items, :only => [] do
    get :category, :on => :collection
    get :ware_item, :on => :collection
  end
  resources :ware_houses do
    get :completed, :on => :member
    get :canceled, :on => :member
    resources :input_items do
      get :current_ctg_mtrl, :on => :collection
      get :select_ctg_mtrl, :on => :collection
      get :input_item_create, :on => :collection
    end
  end
  resources :stocks do
    get :download_append, :on => :member
  end
  resources :retrievals do
    get :completed, :on => :member
    get :canceled, :on => :member
    get :download_append, :on => :member
    resources :output_items do
      get :current_stock, :on => :collection
      get :select_stock, :on => :collection
      get :output_item_create, :on => :collection
    end
  end
  resources :projects do
    get :outbound, :on => :member
    resources :picks do
      get :completed, :on => :member
      get :canceled, :on => :member
      resources :pick_items do
        get :current_stock, :on => :collection
        get :select_stock, :on => :collection
        get :pick_item_create, :on => :collection
      end
    end
  end
  resources :exp_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
    get :opening, :on => :collection
    get :prcing, :on => :collection
    get :cmpt, :on => :collection
    get :opening_show, :on => :member
    get :prospecting, :on => :member
    get :exp_msg, :on => :member
    get :exp_progress, :on => :member
  end
  resources :prst_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :aprv_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :pay_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :cstr_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :cstr_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :vst_forms do
    get :download_attachment, :on => :member
    get :download_append, :on => :member
  end
  resources :flower

  root :to => 'controls#index'
end
