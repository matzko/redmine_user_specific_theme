require 'application_helper'

module RedmineUserSpecificTheme::Patches
  module ApplicationHelperPatch
    extend ActiveSupport::Concern

    def self.included(base)
      base.send(:prepend, InstanceMethods)
    end

    module InstanceMethods
      def current_theme
        user_theme = Redmine::Themes.theme(User.current.pref.ui_theme)
        user_theme || Redmine::Themes.theme(Setting.ui_theme)
      end

      def body_css_classes
        css_classes = super
        user_theme = Redmine::Themes.theme(User.current.pref.ui_theme)
        user_theme ?
            css_classes.gsub(/theme-\S+/, "theme-#{user_theme.name}") :
            css_classes
      end
    end
  end
end
