module Jesture
  
  class Config
    attr_reader :jestures, :combos
    
    def initialize(file = File.join(RAILS_ROOT, "config", "jestures.rb"))
      @jestures = {}
      @combos = {}
      self.instance_eval(File.read(file))
    end
    
    def combo(name, sequence)
      @combos[name] = sequence
    end
    
    def jesture(name, &block)
      raise "I need a block" if !block_given?
      @jestures[name] = JestureDefinition.new(&block)
    end
    
    class JestureDefinition
      attr_reader :triggers
      
      def initialize(&block)
        @triggers = []
        self.instance_eval(&block)
      end
      
      def presses(combo_name, str = nil, &block)
        @triggers << [ combo_name, block_given? ? block.call : "#{str}()" ]
      end
    end
    
  end
  
  module ControllerMethods
    # Callback to be invoked upon inclusion into ApplicationController
    def self.included(base)
      base.send :alias_method,  :initialize_without_jestures, :initialize
      base.send :alias_method,  :initialize,                  :initialize_with_jestures
      base.send :helper_method, :provide_jesture, :provide_jesture_tag
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
    
    def provide_jesture(name)
      config = Jesture::Config.new
      
      result = []
      jesture = config.jestures[name]
      jesture.triggers.each do |t|
        sequence  = config.combos[t.first]
        js_call   = t.last
        
        result << generate_js(js_call, sequence)
      end
      result.join() 
    end
    
    def provide_jesture_tag(*args)
      <<-TAG
        <script type="text/javascript">
          #{provide_jesture(*args)}
        </script>
      TAG
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
  end
end