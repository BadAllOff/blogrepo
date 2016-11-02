RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.included_models = ['Article','Article::Translation', 'Book','Book::Translation','User', 'Role', 'Comment']


  config.model Article do

    configure :pub_date do
      strftime_format "%Y-%m-%d %H:%M:%S"
    end
    configure :translations, :globalize_tabs

    configure :tag_list do
      hide
    end
    configure :content do
      hide
    end
    configure :preview do
      hide
    end
    configure :title do
      hide
    end
    configure :comments do
      hide
    end

  end

  config.model 'Article::Translation' do
    visible false
    configure :content, :ck_editor
    configure :preview, :ck_editor
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :preview, :content
  end

  config.model Book do
    configure :translations, :globalize_tabs
    configure :tag_list do
      hide
    end
    configure :comments do
      hide
    end
  end

  config.model 'Book::Translation' do
    visible false
    configure :locale, :hidden do
      help ''
    end
    include_fields :locale, :title, :author, :description
  end

end
