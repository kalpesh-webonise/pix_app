class SystemSetting < ActiveRecord::Base
  serialize :value, Hash
end
