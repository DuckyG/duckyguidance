def student_row(name)
  within '#students' do
    find('tr', :text => /#{name}/)
  end
end

def click_text(locator)
  find(:xpath, XPath.descendant(:*).where(XPath.text.contains(locator))).click
end
