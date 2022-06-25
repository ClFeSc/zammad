class AddRoleIntegrationToSamlSettings < ActiveRecord::Migration[6.1]
  def change
    return if !Setting.exists?(name: 'system_init_done')

    setting = Setting.find_by(name: 'auth_saml_credentials')
    return if !setting

    form = setting.options[:form]
    form <<
      {
        display:     'Synchronize roles',
        null:        true,
        name:        'role_sync',
        tag:         'boolean',
        options: {
          true  => 'yes',
          false => 'no',
        },
      }
    setting.save!
  end
end