module CanaryTest
  module Actions
    autoload :FileCreation, 'canary_test/actions/file_creation'
    autoload :FileDeletion, 'canary_test/actions/file_deletion'
    autoload :FileModification, 'canary_test/actions/file_modification'
    autoload :HttpRequest, 'canary_test/actions/http_request'
    autoload :ProcessCreation, 'canary_test/actions/process_creation'

    def self.get_action(name)
      action_class = name.split('_').collect(&:capitalize).join
      action_klass = Object.const_get([self.name, action_class].join("::"))
    rescue NameError
      raise MissingActionError, "Action `#{name}` does not match an available action."
    end
  end
end
