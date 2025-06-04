package com.example.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.project.dto.Article;
import com.example.project.dto.Member;

@Mapper
public interface ArticleDao {

	@Insert("""
			INSERT INTO article
			    SET regDate = NOW()
			        , boardId = #{boardId}
			        , updateDate = NOW()
			        , memberId = #{loginedMemberId}
			        , title = #{title}
			        , content = #{content}
			        , memberCategory = #{memberCategory}
			""")
	public void writeArticle(String title, String content, int loginedMemberId, int boardId, int memberCategory);

	@Select("""
			<script>
			SELECT a.*, m.loginId
			    FROM article a
			    INNER JOIN `member` m
			    ON a.memberId = m.id
			    WHERE boardId = #{boardId}
			    <if test="keyWord != ''">
			    	<choose>
			    		<when test="searchType == 'title'">
				    		AND a.title LIKE CONCAT('%', #{keyWord}, '%')
			    		</when>
					    <when test="searchType == 'content'">
					    	AND a.content LIKE CONCAT('%', #{keyWord}, '%')
					    </when>
					    <otherwise>
					    	AND (
					    		a.title LIKE CONCAT('%', #{keyWord}, '%')
					    		OR a.content LIKE CONCAT('%', #{keyWord}, '%')
					    	)
					    </otherwise>
			    	</choose>
			    </if>
				ORDER BY a.id DESC
				LIMIT #{limitFrom}, #{articlesInPage}
				</script>
			""")
	public List<Article> getArticles(String keyWord, String searchType, int boardId, int articlesInPage, int limitFrom);

	@Select("""
			<script>
			SELECT COUNT(id)
				FROM article
				WHERE boardId = #{boardId}
				<if test="keyWord != ''">
		    	<choose>
		    		<when test="searchType == 'title'">
			    		AND a.title LIKE CONCAT('%', #{keyWord}, '%')
		    		</when>
				    <when test="searchType == 'content'">
				    	AND a.content LIKE CONCAT('%', #{keyWord}, '%')
				    </when>
				    <otherwise>
				    	AND (
				    		a.title LIKE CONCAT('%', #{keyWord}, '%')
				    		OR a.content LIKE CONCAT('%', #{keyWord}, '%')
				    	)
				    </otherwise>
		    	</choose>
			    </if>
	    	</script>
			""")
	public int getArticlesCnt(int boardId, String keyWord, String searchType);
	
	@Select("""
			SELECT a.*, m.loginId
			 	FROM article a
			 	INNER JOIN `member` m
			 	ON a.memberId = m.id
			 	WHERE a.id = #{id}
			""")
	public Article getArticleById(int id);
	
	@Update("""
			UPDATE article
			    SET updateDate = NOW()
			        , title = #{title}
			        , content = #{content}
			    WHERE id = #{id}
			""")
	public void modifyArticle(int id, String title, String content);

	@Delete("""
			DELETE FROM article
				WHERE id = #{id}
			""")
	public void deleteArticle(int id);

	@Select("""
			SELECT LAST_INSERT_ID()
			""")
	public int getLastArticleId();

	@Update("""
			UPDATE article
				SET viewCnt = viewCnt + 1
				WHERE id = #{id}
			""")
	public void increaseViewCnt(int id);

	@Select("""
			SELECT *
				FROM article
				WHERE memberCategory = #{memberCategory}
			""")
	public Member getMemberByMemberCategory(int memberCategory);

}