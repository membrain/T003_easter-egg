module Jesture
  
  class Config
    def initialize
      @configs = {}
      self.instance_eval(File.read(File.join(RAILS_ROOT, "config", "jestures.rb")))
    end
    
    def method_missing(sym, *args)
      @configs[sym] ||= []
      @configs[sym] << args
    end
    
    def emit
      puts "#{@configs.inspect}"
    end
  end
  
  module ControllerMethods
    # Callback to be invoked upon inclusion into ApplicationController
    def self.included(base)
      base.send :alias_method,  :initialize_without_jestures, :initialize
      base.send :alias_method,  :initialize,                  :initialize_with_jestures
      base.send :helper_method, :jestures
    end
  
    private
  
    # This method replaces ApplicationController's initialize method (inheritted from
    # ActionController::Base), so that we can get our instance variables set without
    # having to explicitly set them in ApplicationController. 
    def initialize_with_jestures(*args)
      initialize_without_jestures(*args)
      @combos   = {}
      @actions  = []
    end
  
    def combo(name, sequence)
      raise "Expected a name definition, but found Nil" unless name
      raise "Expected a sequence, but found Nil" unless sequence
      raise "The supplied sequence is empty" if sequence.empty?
    
      @combos[name.to_sym] = sequence
    end
  
    def trigger(def_name, *args, &block)
      raise "Expected a string or a symbol for def_name, but found Nil" unless def_name
    
      sequence = @combos[def_name.to_sym]
    
      if block_given?
        call = block.call
      else
        fn      = args.shift
        js_args = args.map { |arg| ActiveSupport::JSON.encode(arg) }.join(", ")
        call    = "#{fn}(#{js_args});"
      end
    
      @actions << generate_js(call, sequence)
    end
  
    def generate_js(call, sequence)
      <<-JS
        Event.observe(document, "keydown", (function() {
          var l = function(evt) {
            var f   = arguments.callee,
                seq = f.seq;
              
            if(seq[f.i] === evt.keyCode) {
              f.i++;
            } else {
              f.i = 0;
            }
          
            if(f.i === seq.length) {
              f.i = 0;
              #{call}
            }
          }
        
          l.seq = #{ActiveSupport::JSON.encode(sequence)};
          l.i   = 0;
        
          return l;
        })());
      JS
    end
  
    def jestures
      @actions.join
    end
  end
end