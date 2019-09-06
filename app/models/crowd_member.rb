class CrowdMember < ApplicationRecord
  include RailsEvent::CrowdMember
end unless defined? CrowdMember
