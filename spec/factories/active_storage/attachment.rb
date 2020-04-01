FactoryBot.define do
  factory :attachment, class: ActiveStorage::Attachment do
    name {'images'}
    record_type {'Item'}
    record_id {'1'}
    association :blob, factory: :blob
  end
end