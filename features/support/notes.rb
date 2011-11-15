module NoteHelpers
  def have_note_content(note, user)
    if user.director?
        page_has_note_content(note, :should)
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
