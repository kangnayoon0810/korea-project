package com.example.project.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.project.dto.Board;

@Mapper
public interface BoardDao {

	@Select("""
			SELECT *
				FROM board
				WHERE id = #{boardId}
			""")
	Board getBoard(int boardId);
}