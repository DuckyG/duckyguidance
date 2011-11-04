module NoteHelpers
  def have_note_content(note, user)
    if user.director?
      if note.confidentiality_level == "just_me"
        page_has_note_content(note, :should_not)
      else
        page_has_note_content(note, :should)
      end
    else
      if note.counselor == user or note.confidentiality_level == "department"
        page_has_note_content(note, :should)
      else
        page_has_note_content(note, :should_not)
      end
    end
  end

  def page_has_note_content(note, expectation)
    page.send(expectation, have_content(note.summary))
    page.send(expectation, have_content(note.notes))
  end
end

World(NoteHelpers)
