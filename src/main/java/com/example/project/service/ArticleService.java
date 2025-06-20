package com.example.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.project.dao.ArticleDao;
import com.example.project.dto.Article;

@Service
public class ArticleService {

	private ArticleDao articleDao;

	public ArticleService(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public void writeArticle(String content, int loginedMemberId, int boardId, int memberCategory) {
		this.articleDao.writeArticle(content, loginedMemberId, boardId, memberCategory);
	}

	public List<Article> getArticles(String keyWord, int boardId, int articlesInPage, int limitFrom, String sortType) {
		return this.articleDao.getArticles(keyWord, boardId, articlesInPage, limitFrom, sortType);
	}
	
	public Article getArticleById(int id) {
		return this.articleDao.getArticleById(id);
	}

	public void modifyArticle(int id, String content) {
		this.articleDao.modifyArticle(id, content);
	}

	public void deleteArticle(int id) {
		this.articleDao.deleteArticle(id);
	}

	public int getLastArticleId() {
		return this.articleDao.getLastArticleId();
	}
	
	public int getArticlesCnt(int boardId, String keyWord) {
		return this.articleDao.getArticlesCnt(boardId, keyWord);
	}

	public void increaseViewCnt(int id) {
		this.articleDao.increaseViewCnt(id);
	}
	
	public Article getArticleByMemberCategory(int memberCategory) {
		return this.articleDao.getArticleByMemberCategory(memberCategory);
	}


}