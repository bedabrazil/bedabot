class InterpretService
  def self.call action, params
    case action
    when "list_faq", "search_faq", "search_faq_by_hashtag"
      FaqModule::ListService.new(params, action).call
    when "create_faq"
      FaqModule::CreateService.new(params).call
    when "remove_faq"
      FaqModule::RemoveService.new(params).call
    when 'list_link', 'search_link', 'search_link_by_tag'
      LinkModule::ListService.new(params, action).call
    when "remove_link"
      LinkModule::RemoveService.new(params).call
    when "help"
      HelpService.call
    else
      "Não compreendi o seu desejo"
    end
  end
end