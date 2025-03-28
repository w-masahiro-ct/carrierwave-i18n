# frozen_string_literal: true

require 'rails'

module CarrierWaveI18n
  class Railtie < ::Rails::Railtie
    initializer 'carrierwave-i18n' do |app|
      CarrierWaveI18n::Railtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales

        add("rails/locales/#{pattern}.yml")
      end
    end

    class << self
      protected

      def add(pattern)
        files = Dir[File.join(File.dirname(__FILE__), '../..', pattern)]

        I18n.load_path.concat(files)
      end

      def pattern_from(args)
        array = Array(args || [])
        array.blank? ? '*' : "{#{array.join ','}}"
      end
    end
  end
end
