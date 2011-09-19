module ApplicationHelper
  
end

class DuckyFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::RawOutputHelper
  include ActiveSupport::Inflector
  def required_field_label(method, text = nil)
    label method, raw("<span class='req'>* </span>#{text ? text : humanize(method)}")
  end
end

ActionView::Base.default_form_builder = DuckyFormBuilder