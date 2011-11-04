module NoteHelpers
  def have_note_content(note, expectation)
    page.send(expectation, have_content(note.summary))
    page.send(expectation, have_content(note.notes))
  end
end

World(NoteHelpers)
