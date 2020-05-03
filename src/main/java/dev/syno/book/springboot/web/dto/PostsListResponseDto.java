package dev.syno.book.springboot.web.dto;

import dev.syno.book.springboot.domain.posts.Posts;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class PostsListResponseDto {
    private Long id;
    private String author;
    private String title;
    private LocalDateTime modifiedDate;

    public PostsListResponseDto(Posts entity){
        this.id = entity.getId();
        this.author = entity.getAuthor();
        this.title = entity.getTitle();
        this.modifiedDate = entity.getModifiedDate();
    }

}
