package com.example.project.controller;

import java.util.List;

import javax.xml.stream.events.Comment;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.project.dto.Comments;
import com.example.project.dto.LikePoint;
import com.example.project.dto.Req;
import com.example.project.dto.ResultData;
import com.example.project.service.ArticleService;
import com.example.project.service.BoardService;
import com.example.project.service.CommentsService;

@Controller
public class UsrCommentsController {

	private CommentsService commentsService;
	private Req req;

	public UsrCommentsController(CommentsService commentsService, Req req) {
		this.commentsService = commentsService;
		this.req = req;
	}

	@PostMapping("/usr/comments/doWrite")
	@ResponseBody
	public String doWrite(@RequestParam int relId, @RequestParam String relTypeCode, @RequestParam String comment) {

		this.commentsService.writeComment(comment, relTypeCode, this.req.getLoginedMember().getId(), relId);

		return "댓글이 등록되었습니다";
	}

	@GetMapping("/usr/comments/getComment")
	@ResponseBody
	public Comment getComment(int id) {
		return this.commentsService.getCommentById(id);
	}

	@GetMapping("/usr/comments/getComments")
	@ResponseBody
	public ResultData<Integer> getComments(String relTypeCode, int relId) {

		Comment comment = this.commentsService.getComment(this.req.getLoginedMember().getId(), relTypeCode, relId);
		int commentsCnt = this.commentsService.getCommentsCnt(relTypeCode, relId);

		if (comment == null) {
			return ResultData.from("F-1", "댓글 정보 조회 실패", commentsCnt);
		}

		return ResultData.from("S-1", "댓글 정보 조회 성공", commentsCnt);
	}

	@GetMapping("/usr/comments/list")
	@ResponseBody
	public List<Comments> list(Model model, @RequestParam int relId, @RequestParam String relTypeCode) {

		List<Comments> comments = this.commentsService.getComments(relId, relTypeCode);

		return comments;
	}

	@PostMapping("/usr/comments/delete")
	@ResponseBody
	public void delete(int id) {

		this.commentsService.deleteComment(id);
	}

	@PostMapping("/usr/comments/modify")
	@ResponseBody
	public void modify(int id, String content) {

		this.commentsService.modifyComment(id, content);
	}
}