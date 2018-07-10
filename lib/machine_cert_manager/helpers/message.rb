module MachineCertManager
  module Helpers
    # This helper provides useful error methods,
    # which may abort the script with an error message
    # and a stack traceback.
    module Message
      MESSAGE_PADDING     = '  '
      STACK_TRACE_SIZE    = 20
      STACK_TRACE_PADDING = 1
      private
        def error *messages
          message = messages.flatten.join(?\n).gsub(/^/, MESSAGE_PADDING)
          stack_trace = caller[STACK_TRACE_PADDING ... (STACK_TRACE_SIZE + STACK_TRACE_PADDING)].map do |line|
            next "#{MESSAGE_PADDING}#{line}"
          end .reverse
          abort([
            "Stack traceback (most recent call last):",
            stack_trace,
            "#{DIR[:entry].to_path} ERROR:",
            message,
            "#{MESSAGE_PADDING}Exiting."
          ].flatten.join(?\n))
        end

        def warning *messages
          message = _get_warning_message_from(*messages.flatten)
          puts message
        end

        def warning_print *messages
          message = _get_warning_message_from(*messages.flatten)
          print message
        end

        def message *messages
          message = messages.flatten.join(?\n).gsub(/^/, MESSAGE_PADDING)
          puts([
            "#{DIR[:entry].to_path}",
            message
          ].flatten.join(?\n))
        end

        def _get_warning_message_from *messages
          message = messages.flatten.join(?\n).gsub(/^/, MESSAGE_PADDING)
          return [
            "#{DIR[:entry].to_path} WARNING:",
            message
          ].flatten.join(?\n)
        end
    end
  end
end