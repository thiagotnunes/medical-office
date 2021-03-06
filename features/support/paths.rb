module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the show page for (.+)/
      polymorphic_path(model($1))
    when /the path "(.+)"/
      $1
    when /the health_insurances list/
      health_insurances_path
    when /the telephone_labels list/
      telephone_labels_path
    when /the plastic_surgery_patients list/
      plastic_surgery_patients_path
    when /the occupational_therapy_patients list/
      occupational_therapy_patients_path
    when /the dermatology_patients list/
      dermatology_patients_path
    when /the address_labels list/
      address_labels_path
    when /the patient_history_labels list/
      patient_history_labels_path
    when /the login page/
      new_user_session_path
    

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
