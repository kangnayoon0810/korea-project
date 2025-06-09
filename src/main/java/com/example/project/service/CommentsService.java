package com.example.project.service;

import java.util.List;

import javax.xml.stream.events.Comment;

import org.springframework.stereotype.Service;

import com.example.project.dao.CommentsDao;
import com.example.project.dto.Comments;

@Service
public class CommentsService {
	private CommentsDao commentsDao;

	public CommentsService(CommentsDao commentsDao) {
		this.commentsDao = commentsDao;
	}
	
	public void writeComment(String comment, String relTypeCode, int loginedMemberId, int relId) {
		this.commentsDao.writeComment(comment, relTypeCode, loginedMemberId, relId);
	}
	
	public List<Comments> getComments(int relId, String relTypeCode) {
		return this.commentsDao.getComments(relId, relTypeCode);
	}
	
	public int getLastInsertCommentId() {
		return this.commentsDao.getLastInsertCommentId();
	}
	
	public Comment getCommentById(int id) {
		return this.commentsDao.getCommentById(id);
	}
	
	public void deleteComment(int id) {
		this.commentsDao.deleteComment(id);
	}

	public void modifyComment(int id, String comment) {
		this.commentsDao.modifyComment(id, comment);
	}

	public Comment getComment(int id, String relTypeCode, int relId) {
		return this.commentsDao.getComment(id, relTypeCode, relId);
	}

	public int getCommentsCnt(String relTypeCode, int relId) {
		return this.commentsDao.getCommentsCnt(relTypeCode, relId);
	}

}
