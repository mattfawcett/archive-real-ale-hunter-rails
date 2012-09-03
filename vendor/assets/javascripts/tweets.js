$(document).ready(function(){
    $(".tweet").tweet({
        join_text: "auto",
        avatar_size: 32,
        count: 4,
        auto_join_text_default: "",
		query: ["real ale"]
    });
});