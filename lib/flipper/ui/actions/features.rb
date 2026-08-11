require 'flipper/ui/action'
require 'flipper/ui/decorators/feature'
require 'flipper/ui/util'

module Flipper
  module UI
    module Actions
      class Features < UI::Action
        route %r{\A/features/?\Z}

        def get
          @page_title = 'Features'
          @search = params['search'].to_s
          @search = nil if Util.blank?(@search)

          keys = flipper.features.map(&:key)
          descriptions = if Flipper::UI.configuration.show_feature_description_in_list?
            Flipper::UI.configuration.descriptions_source.call(keys)
          else
            {}
          end

          @features = flipper.features.map do |feature|
            decorated_feature = Decorators::Feature.new(feature)

            if Flipper::UI.configuration.show_feature_description_in_list?
              decorated_feature.description = descriptions[feature.key]
            end

            decorated_feature
          end.sort

          # Substring match on key, not name: Feature#name may be a Symbol, and
          # #key is also what the list renders. include? rather than match so a
          # search like "[" is literal text instead of an invalid regex.
          @features = @features.select { |feature| feature.key.include?(@search) } if @search

          # Only a genuinely empty backend gets the blank slate. A zero-result
          # search must still render the card so the search box stays reachable.
          @show_blank_slate = @features.empty? && @search.nil?

          breadcrumb 'Home', '/'
          breadcrumb 'Features'

          view_response :features
        end

        def post
          read_only if Flipper::UI.configuration.read_only

          unless Flipper::UI.configuration.feature_creation_enabled
            status 403

            breadcrumb 'Home', '/'
            breadcrumb 'Features', '/features'
            breadcrumb 'Noooooope'

            halt view_response(:feature_creation_disabled)
          end

          value = params['value'].to_s.strip

          if Util.blank?(value)
            error = "#{value.inspect} is not a valid feature name."
            redirect_to("/features/new?error=#{error}")
          end

          feature = flipper[value]
          feature.add

          redirect_to "/features/#{value}"
        end
      end
    end
  end
end
