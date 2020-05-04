class JobsheetStateTracker < ApplicationRecord
  belongs_to :jobsheet
  belongs_to :jobsheet_state
end
