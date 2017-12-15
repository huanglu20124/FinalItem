package com.finalItem.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import com.finalItem.dao.NoteDao;
import com.finalItem.dao.RatDao;
import com.finalItem.domain.Note;
import com.finalItem.domain.SimpleNote;
import com.finalItem.util.Const;
import com.finalItem.util.TimeUtil;

import sun.net.www.content.text.plain;

public class NoteService {
	private NoteDao noteDao = new NoteDao();
	private RatDao ratDao = new RatDao();
	
	public List<Note> getHotNote(HttpServletRequest request, HttpServletResponse response) {
		// 得到5个最新的的热门贴，点赞数量要大于10，用于滚动视图演示
		// 仅返回帖子id 标题 和图片
		List<Note> notes = null;
		notes = noteDao.getFiveHotNotes();
		if (notes != null) {
			for (Note note : notes) {
				List<String> images = noteDao.getNoteImage(note.getNote_id());
				note.setImages(images);
			}
		} else {
			notes = new ArrayList<>();
		}
		return notes;
	}

	public List<SimpleNote> getSimpleNotes(HttpServletRequest request, HttpServletResponse response) {
		// 根据时间顺序分页查询帖子(包含标题 作者 时间 id等文字内容s),5条
		List<SimpleNote> notes = null;
		String page_str = request.getParameter("page");
		if(page_str == null) page_str = "0";
		notes = noteDao.getSimpleNotes(page_str);
		if (notes == null) {
			notes = new ArrayList<>();
		}
		// 同时，查询总页数，放到session域中
		if (request.getSession().getAttribute("page_num") == null) {
			Integer page_sum = noteDao.getNoteSum();
			request.getSession().setAttribute("page_sum", page_sum);
		}
		return notes;
	}

	public String addNote(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		String content = (String) session.getAttribute("content");
		if(content == null) content = "";//编辑文字加上图片标签
		Integer flag = (Integer) session.getAttribute("flag");
		if(flag == null) flag = 0;//记录编辑的文字的最后一个字符位置
		
		String image_url = null;
		int type = 0; //0,1,2分别代表上传，保存，退出
		// 上传图片+文字内容，成功的话跳转回首页，失败的话返回信息msg
		String msg = ""; 
		ServletContext context = request.getServletContext();
		// 先创建文件文件夹
		String dir = request.getServletContext().getRealPath("/file");
		File directory = new File(dir);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		// 创建工厂
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 生产文件上传核心类
		ServletFileUpload fileUpload = new ServletFileUpload(factory);
		boolean isMultipart = fileUpload.isMultipartContent(request);// 检查表单中是否包含文件
		if (!isMultipart) {
			throw new RuntimeException("表单格式不正确！");
		}
		// --设置编码集,解决上传文件名的乱码问题
		fileUpload.setHeaderEncoding("utf-8");
		try {
			if (isMultipart) {
				List<FileItem> items = fileUpload.parseRequest(request);
				Note note = new Note();
				for (int i = 0; i < items.size(); i++) {
					FileItem fileItem = items.get(i);
					if (fileItem.isFormField()) {
						System.out.print("---" + fileItem.getFieldName());
						// 如果是表单
						switch (fileItem.getFieldName()) {
						case "note_title":
							note.setNote_title(fileItem.getString("utf-8"));
							break;
						case "note_content":
							note.setNote_content(fileItem.getString("utf-8"));
							break;
						case "user_id":
							note.setUser_id(new Integer(fileItem.getString("utf-8")));
							break;
						case "rat_id":
							note.setRat_id(new Integer(fileItem.getString("utf-8")));
							break;
						case "uploadFile":
							// System.out.println("接收到uploadFile");
							if (fileItem.getString("utf-8") != null)type = 0;
					        break;
						case "save":
							if (fileItem.getString("utf-8") != null)type = 1;
					        break;	
						case "exit":
							if (fileItem.getString("utf-8") != null)type = 2;
					        break;					    
						default:
							break;
						}
					} else {
						// 如果是文件
						try {
							DiskFileItem fi = (DiskFileItem) fileItem;
							if (!fi.getName().trim().equals("")) {// getName()返回文件名称或空串
								String id = UUID.randomUUID().toString().substring(0, 10);
								//String filePath = context.getRealPath("/file") + System.getProperty("file.separator")+ id + "_" + FilenameUtils.getName(fi.getName());
								String filePath = Const.FILE_PATH + id + "_" + FilenameUtils.getName(fi.getName()); 
								fi.write(new File(filePath));
								image_url = id + "_" + FilenameUtils.getName(fi.getName());
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				System.out.println("处理文件完毕");
				if (type == 0) {
					// 保存图片到session中
					List<String> images = (List<String>) session.getAttribute("images");
					if (images == null)
						images = new ArrayList<>();
					if (image_url != null) {
						images.add(image_url);
					}
					session.setAttribute("images", images);
					session.setAttribute("note", note);
					//补充增加的文字内容
					Integer length = (Integer) session.getAttribute("length");
					if(length == null) length = 0;
					
					if((content.length() - length) < note.getNote_content().length()){
						//说明增加了文字内容
						if(content.length() == 0){
							content = note.getNote_content();
							flag = note.getNote_content().length();
						}else {
							String content_temp = note.getNote_content();
							String add_content = content_temp.substring(flag,content_temp.length());
							content += add_content;
							flag = content_temp.length();
						}
					}

					//实际内容加上真标签
					String add_str = "<br><img class='hamsterimg' src='"+Const.FILE_IP + image_url + "'><br>";
					content += add_str;
					length += add_str.length();
					
					//存储这些数据
					session.setAttribute("length", length);
					session.setAttribute("content", content);
					session.setAttribute("flag", flag);
					System.out.println("flag=" + flag + "length=" + length);
					System.out.println("content=" + content);
				}
				else if(type == 1){
					List<String> images = (List<String>) session.getAttribute("images");
					note.setImages(images);
					// 补充信息，写入数据库
					note.setNote_uuid(UUID.randomUUID().toString());
					note.setNote_time(TimeUtil.getCurrentTime());
					//设置content
					note.setNote_content(content);
					Integer note_id = noteDao.addNote(note);
					if (note_id == null) {
						msg = "发布帖子失败";
						// 删除上传的图片
						for (String image : images) {
							String image_path = context.getRealPath("/file") + System.getProperty("file.separator")
									+ image;
							File file = new File(image_path);
							if (file.exists()) {
								file.delete();
							}
						}
					} else {
						msg = "发布帖子成功";
						// 同时保存图片
						if(images != null){
							for (String image : images) {
								noteDao.addNoteImage(note_id, image);
							}
						}
						session.removeAttribute("images");
						session.removeAttribute("note");
						session.removeAttribute("flag");
						session.removeAttribute("content");
						session.removeAttribute("length");
						// 重定向到主页
						response.sendRedirect("index.jsp?page=0");
					}
				}
				else if (type == 2){
					//退出，删除帖子和session的图片，重定向到首页
					List<String> images = (List<String>) session.getAttribute("images");
					if(images != null){
						for (String image : images) {
							String image_path = context.getRealPath("/file") + System.getProperty("file.separator")
									+ image;
							File file = new File(image_path);
							if (file.exists()) {
								file.delete();
							}
						}
						session.removeAttribute("images");
						session.removeAttribute("note");
						session.removeAttribute("flag");
						session.removeAttribute("content");
						session.removeAttribute("length");
					}
					response.sendRedirect("index.jsp?page=0");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			msg = "上传文件出现错误";
		}
		return msg;
	}

	public Note getOneNote(HttpServletRequest request, HttpServletResponse response) {
		// 获取详情页需要的信息
		Integer note_id = new Integer(request.getParameter("note_id"));
		Note note = noteDao.getOneNote(note_id);
		// 查询图片
		if (note != null) {
			List<String> images = noteDao.getNoteImage(note_id);
			note.setImages(images);
		}
		return note;
	}

	public List<SimpleNote> getUserSimpleNotes(Integer user_id){
		//得到用户的帖子，不搞分页
		List<SimpleNote>list = noteDao.getUserSimpleNotes(user_id);
		if(list == null) list = new ArrayList<>();
		return list;
	}

	public String addGood(Integer note_id,Integer rat_id,String type){
		if(type.equals("0")){
			//增加
			noteDao.addNoteGood(note_id);
			ratDao.addRatGood(rat_id);
		}else {
			//减少
			noteDao.minusNoteGood(note_id);
			ratDao.minusRatGood(note_id);
		}
		return "修改成功";
	}

	public int deleteNote(Integer note_id){
		return noteDao.deleteNote(note_id);
	}
}
