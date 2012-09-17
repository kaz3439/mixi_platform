module MixiPlatform
  class OAuth
     module Configure
          attr_accessor :consumer_key, :consumer_secret, :redirect_url
   
          def keys
            @keys ||= [
              :consumer_key,
              :consumer_secret,
              :redirect_url
            ]
          end
  
          def configure
            yield self
            self
          end
   
          def credentials?
            credentials.values.all?
          end
  
          def credentials
            Hash[keys.map{|key| [key, instance_variable_get("@#{key}")]}]
          end
  
          def self.included(mod)
            mod.extend Configure
          end
  
      end #Configure
  end #OAuth
end #MixiPlatform
