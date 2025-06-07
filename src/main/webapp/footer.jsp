<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String now = sdf.format(new Date());
%>
<footer class="py-4 bg-dark">
    <div class="container">
        <p class="m-0 text-center text-white" style="font-size:1.1rem;">
            현재 접속 시간 : <span id="nowTime"><%= now %></span>
        </p>
    </div>
</footer>
<script>
    // 서버에서 전달받은 시간 문자열을 Date 객체로 변환
    let nowStr = "<%= now %>";
    let date = new Date(nowStr.replace(/-/g, '/'));

    function pad(n) { return n < 10 ? '0' + n : n; }

    function updateTime() {
        date.setSeconds(date.getSeconds() + 1);
        let yyyy = date.getFullYear();
        let MM = pad(date.getMonth() + 1);
        let dd = pad(date.getDate());
        let hh = pad(date.getHours());
        let mm = pad(date.getMinutes());
        let ss = pad(date.getSeconds());
        let formatted = yyyy + '-' + MM + '-' + dd + ' ' + hh + ':' + mm + ':' + ss;
        document.getElementById('nowTime').textContent = formatted;
    }

    setInterval(updateTime, 1000);
</script>
