module OpenAI
  module Assistant
    class Replyer
      def initialize(model: "gpt-3.5-turbo", incoming_mail: "", reply_summary: "", situation: 'formal', other_request: "")
        return if incoming_mail.empty? || reply_summary.empty?

        @prompt_data = prompt_data(model:model, incoming_mail: incoming_mail, reply_summary: reply_summary, situation: situation, other_request: other_request)
      end

      def prompt_data(model:, incoming_mail:, reply_summary:, situation:, other_request:)
        {
          model: model,
          incoming_mail: incoming_mail,
          reply_summary: reply_summary,
          situation: situation,
          other_request: other_request
        }
      end

      def get_prompt_data(model:, incoming_mail:, reply_summary:, situation:, other_request:)
        @prompt_data
      end

      def set_prompt_data(model:, incoming_mail:, reply_summary:, situation:, other_request:)
        @prompt_data[:incoming_mail] = incoming_mail if !incoming_mail.empty?
        @prompt_data[:reply_summary] = reply_summary if !reply_summary.empty?
        @prompt_data[:situation] = situation if !situation.empty?
        @prompt_data[:other_request] = other_request if !other_request.empty?
      end

      def parameters
        {
          model: @prompt_data[:model],
          messages: [
            { role: "system", content: system_prompt },
            # { role: "user", content: user_prompt }
          ],
          temperature: 0.7,
        }
      end

      private

      def system_prompt
        system_prompt = []
        system_prompt << "状況:" + @prompt_data[:situation]
        system_prompt << "返信したい内容:" + @prompt_data[:reply_summary]
        system_prompt << "受信したメール:" + @prompt_data[:incoming_mail]
        system_prompt << "その他要望:" + @prompt_data[:other_request] if @prompt_data[:other_request].empty?
        system_prompt << "USER: メールの返信を作成してください。\nASSISTANT:"
        system_prompt.join(',')
      end

      def user_prompt
      end
    end
  end
end