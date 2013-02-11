module ApplicationHelper
end

class DuckyFormBuilder < ActionView::Helpers::FormBuilder
  include ActiveSupport::Inflector
  def required_field_label(method, text = nil)
    label method, "<span class='req'>* </span>#{text ? text : humanize(method)}".html_safe
  end
end

ActionView::Base.default_form_builder = DuckyFormBuilder
