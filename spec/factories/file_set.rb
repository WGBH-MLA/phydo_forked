FactoryBot.define do
  factory :file_set, class: FileSet do
    transient do
      user { create(:user) }
      content nil
      pbcore nil
    end

    after(:create) do |file_set, evaluator|
      if evaluator.content
        Hydra::Works::UploadFileToFileSet.call(file_set, evaluator.content)
      end

      if evaluator.pbcore
        # NOTE: http://pcdm.org/use#TOTALLY_FAKE_TYPE comes from the FileSet
        # model.
        # TODO: change this test predicate to be the same as whatever is
        # defined in the FileSet model.
        Hydra::Works::AddFileToFileSet.call(file_set, evaluator.pbcore, ::RDF::URI('http://pcdm.org/use#TOTALLY_FAKE_TYPE'))
      end
    end

    after(:build) do |file_set, evaluator|
      file_set.apply_depositor_metadata(evaluator.user.user_key)
    end
  end
end
