function CheckAddMusic() {
    var musicId = document.getElementById("musicId");
    var musicTitle = document.getElementById("musicTitle");
    var musicSinger = document.getElementById("musicSinger");
    var unitPrice = document.getElementById("unitPrice");
    var description = document.getElementById("description");

    // 음악 ID: 숫자만 허용
    if (musicId.value.trim() === "" || isNaN(musicId.value) || !/^\d+$/.test(musicId.value)) {
        alert("[음악 코드]\n숫자만 입력하세요.");
        musicId.focus();
        return false;
    }

    // 제목: 1~50자
    if (musicTitle.value.length < 1 || musicTitle.value.length > 50) {
        alert("[제목]\n최소 1자에서 최대 50자까지 입력하세요");
        musicTitle.focus();
        return false;
    }

    // 가수: 1~30자
    if (musicSinger.value.length < 1 || musicSinger.value.length > 30) {
        alert("[가수]\n최소 1자에서 최대 30자까지 입력하세요");
        musicSinger.focus();
        return false;
    }

    // 가격: 숫자, 0 이상
    if (unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
        alert("[가격]\n숫자만 입력하세요");
        unitPrice.focus();
        return false;
    }
    if (Number(unitPrice.value) < 0) {
        alert("[가격]\n음수를 입력할 수 없습니다");
        unitPrice.focus();
        return false;
    }

    // 설명: 5자 이상
    if (description.value.length < 5) {
        alert("[설명]\n최소 5자 이상 입력하세요");
        description.focus();
        return false;
    }

    // 모든 검사 통과 시 폼 제출
    document.newMusic.submit();
}
