package com.example.project.service;

import org.springframework.stereotype.Service;

import com.example.project.dao.BoardDao;
import com.example.project.dto.Board;

@Service
public class BoardService {

	private BoardDao boardDao;

	public BoardService(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	public Board getBoard(int boardId) {
		return this.boardDao.getBoard(boardId);
	}
	
}