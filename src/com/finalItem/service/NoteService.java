package com.finalItem.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.finalItem.dao.NoteDao;
import com.finalItem.domain.Note;
import com.finalItem.domain.SimpleNote;
import com.finalItem.util.TimeUtil;

public class NoteService {
	private NoteDao noteDao = new NoteDao();

	public List<Note> getHotNote(HttpServletRequest request, HttpServletResponse response) {
		// 得到5个最新的的热门贴，点赞数量要大于10，用于滚动视图演示
		// 仅返回帖子id 标题 和图片
		List<Note> notes = null;
		notes = noteDao.getFiveHotNotes();
		if(notes != null){
			for (Note note : notes) {
				List<String> images = noteDao.getNoteImage(note.getNote_id());
				note.setImages(images);
			}
		}else {
			notes = new ArrayList<>();
		}
		return notes;
	}

	public List<SimpleNote> getSimpleNotes(HttpServletRequest request, HttpServletResponse response) {
		// 根据时间顺序分页查询帖子(包含标题 作者 时间 id等文字内容s),5条
		List<SimpleNote> notes = null;
		String page_str = request.getParameter("page");
		if (page_str != null) {
			notes = noteDao.getSimpleNotes(page_str);
		}
		if (notes == null) {
			notes = new ArrayList<>();
		}
		//同时，查询总页数，放到session域中
		if(request.getSession().getAttribute("page_num") == null){
			Integer page_sum = noteDao.getNoteSum();
			request.getSession().setAttribute("page_sum", page_sum);
		}
    	return notes;
	}

	public String addNote(HttpServletRequest request, HttpServletResponse response){
		//上传图片+文字内容，成功的话跳转回首页，失败的话返回信息msg
		String msg = "";
		ServletContext context = request.getServletContext();
		//先创建文件文件夹
		String dir = request.getServletContext().getRealPath("/file");
		File directory = new File(dir);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		//创建工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//生产文件上传核心类
		ServletFileUpload fileUpload = new ServletFileUpload(factory);
		boolean isMultipart = fileUpload.isMultipartContent(request);//检查表单中是否包含文件
		if(!isMultipart){
			throw new RuntimeException("表单格式不正确！");
		}
		//--设置编码集,解决上传文件名的乱码问题
		fileUpload.setHeaderEncoding("utf-8");
		try {
			if (isMultipart) {
				Note note = new Note();
				List<String>images = new ArrayList<>();
				List<FileItem> items = fileUpload.parseRequest(request);
				for (int i = 0; i < items.size(); i++) {
					FileItem fileItem = items.get(i);
					if (fileItem.isFormField()) {
						//如果是表单
						switch (fileItem.getFieldName()) {
						case "note_title":
							note.setNote_title(fileItem.getString("utf-8"));
							break;
						case "note_content":
							note.setNote_content(fileItem.getString("utf-8"));
							break;
						case "user_id":
							note.setUser_id(new Integer(fileItem.getString("user_id")));
							break;
						case "rat_id":
							note.setRat_id(new Integer(fileItem.getString("user_id")));
							break;						
						default:
							break;
						}
					} else {
						//如果是文件
						String id = UUID.randomUUID().toString().substring(0,10);
						try {
							DiskFileItem fi = (DiskFileItem) fileItem;
							if (!fi.getName().trim().equals("")) {//getName()返回文件名称或空串
								String filePath = context.getRealPath("/file")
										+ System.getProperty("file.separator") + id +"_" +FilenameUtils.getName(fi.getName());
								fi.write(new File(filePath));
								String image_url = id +"_" + FilenameUtils.getName(fi.getName());
								images.add(image_url);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				    System.out.println("处理文件完毕");
				    note.setImages(images);
				    //补充信息，写入数据库
				    note.setNote_uuid(UUID.randomUUID().toString());
				    note.setNote_time(TimeUtil.getCurrentTime());
				    Integer note_id =  noteDao.addNote(note);
				    if(note_id == null){
				    	msg = "发布帖子失败";
				    	//删除上传的图片
				    	 for(String image_url : images){
				    		 String image_path = context.getRealPath("/file")+ System.getProperty("file.separator") + image_url;
				    		 File file = new File(image_path);
				    		 if(file.exists()){
				    			 file.delete();
				    		 }
				    	 }
				    }else {
						msg = "发布帖子成功";
						//同时保存图片
						for(String image_url : images){
							noteDao.addNoteImage(note_id,image_url);
						}
						//重定向到主页
						response.sendRedirect("final_item/main.jsp");
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			msg = "上传文件出现错误";
		}
		return msg;
	}

	public Note getOneNote(HttpServletRequest request, HttpServletResponse response){
		//获取详情页需要的信息
		Integer note_id = new Integer(request.getParameter("note_id"));
		Note note = noteDao.getOneNote(note_id);
		//查询图片
		if(note != null){
			List<String>images = noteDao.getNoteImage(note_id);
			note.setImages(images);
		}
		return note;
	}
}
