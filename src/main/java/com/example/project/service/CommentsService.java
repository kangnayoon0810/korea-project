package com.example.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.project.dao.CommentsDao;
import com.example.project.dto.Comments;

@Service
public class CommentsService {
	private CommentsDao commentsDao;

	public CommentsService(CommentsDao commentsDao) {
		this.commentsDao = commentsDao;
	}
	
	public void writeComment(String relTypeCode, int loginedMemberId, int relId, String content) {
		this.commentsDao.writeComment(relTypeCode, loginedMemberId, relId, content);
	}
	
	public List<Comments> getComments(int relId, String relTypeCode) {
		return this.commentsDao.getComments(relId, relTypeCode);
	}
	
	public int getLastInsertCommentId() {
		return this.commentsDao.getLastInsertCommentId();
	}
	
	public Comments getCommentById(int id) {
		return this.commentsDao.getCommentById(id);
	}
	
	public void deleteComment(int id) {
		this.commentsDao.deleteComment(id);
	}

	public void modifyComment(int id, String content) {
		this.commentsDao.modifyComment(id, content);
	}

}
