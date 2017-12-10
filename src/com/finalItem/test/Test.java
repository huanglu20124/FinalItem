package com.finalItem.test;

import java.util.Date;
import java.util.List;

import com.finalItem.dao.NoteDao;
import com.finalItem.domain.Note;
import com.finalItem.domain.SimpleNote;
import com.finalItem.util.TimeUtil;


public class Test {
	public static void main(String[] args) {
		List<SimpleNote> list= new NoteDao().getSimpleNotes("0");
		System.out.println(list);
	}
	
	private void add() {
		Note note = new Note();
		note.setNote_time(TimeUtil.getCurrentTime());
		note.setNote_title("test");
		note.setNote_content("sfsdf");
		note.setNote_uuid("wsfsdf");
		note.setUser_id(1);
		note.setRat_id(1);
		System.out.println(new NoteDao().addNote(note));
	}
}
