require "service_call/version"

module ServiceCall
  def self.included(klass)
    klass.send(:extend, ClassMethods)
  end

  def initialize(**kwargs)
    self.class.attributes.each do |name, properties|
      instance_variable_set("@#{name}", properties[:default])
    end
    kwargs.each do |name, value|
      instance_variable_set("@#{name}", value) if respond_to?(name)
    end
  end

  def call
    fail NotImplementedError
  end

  module ClassMethods
    def attribute(name, default: nil)
      attr_reader name
      self.attributes = attributes.merge(name => { default: default })
    end

    def attributes
      {}
    end

    def attributes=(value)
      singleton_class.class_eval do
        undef_method :attributes
        define_method :attributes do
          value || {}
        end
      end
    end

    def call(*args, **kwargs)
      setters = kwargs.keys.select { |name| method_defined?(name) }
      init_kwargs = kwargs.select { |key, value| setters.include?(key) }
      call_kwargs = kwargs.select { |key, value| !setters.include?(key) }

      # Should work, but bugs will be bugs: https://bugs.ruby-lang.org/issues/11131
      # new(**init_kwargs).call(*args, **call_kwargs)

      service = new(**init_kwargs)
      args << call_kwargs unless call_kwargs.empty?
      service.call(*args)
    end
  end
end
