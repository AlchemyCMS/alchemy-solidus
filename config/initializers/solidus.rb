# In versions of Solidus prior to 2.8, we override this class to
# add the match_path option to the initializer. (Version 2.8 has
# this option already.) This option is used in the tabs partial
# to configure the paths for which a given tab is active.
#
if Spree.solidus_gem_version < Gem::Version.new('2.8')
  Spree::BackendConfiguration::MenuItem.class_eval do
    attr_reader :match_path

    def initialize(
      sections,
      icon,
      condition: nil,
      label: nil,
      partial: nil,
      url: nil,
      match_path: nil
    )

      @condition = condition || -> { true }
      @sections = sections
      @icon = icon
      @label = label || sections.first
      @partial = partial
      @url = url
      @match_path = match_path
    end
  end
end
