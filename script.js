function logout() {
        sessionStorage.clear();
        window.location.href = "landing.html";
    }

function togglePassword(id) {
    const input = document.getElementById(id);
    input.type = input.type === "password" ? "text" : "password";
}

function validateForm() {
    const errorMsg = document.getElementById('errorMsg');
    const password = document.getElementById('password').value;
    const confirm = document.getElementById('confirm').value;
    const contact = document.getElementById('contact').value;

    // Check empty fields
    const fields = ['firstName', 'lastName', 'email', 'username', 'birthday', 'contact', 'password', 'confirm'];
    for (let id of fields) {
        if (!document.getElementById(id).value.trim()) {
            errorMsg.textContent = "Please fill in all fields.";
            return false;
        }
    }

    // Check password match
    if (password !== confirm) {
        errorMsg.textContent = "Passwords do not match!";
        return false;
    }

    // Check password length
    if (password.length < 6) {
        errorMsg.textContent = "Password must be at least 6 characters.";
        return false;
    }

    // Check contact is numbers only
    if (!/^\d+$/.test(contact)) {
        errorMsg.textContent = "Contact number must contain digits only.";
        return false;
    }

    return true;
}

document.addEventListener('DOMContentLoaded', function(){
    
    const LessonCatalog = [
        {ID: "1021", Title: "The Great Gatsby", Author: "F. Scott Fitzgerald", Status: "Available", Action: "Available"},
        {ID: "1021", Title: "Project Hail Mary", Author: "Andy Weir", Status: "Available", Action: "Not Available"},
        {ID: "1021", Title: "Dune", Author: "Frank Herbert", Status: "Available", Action: "Available"},
        {ID: "1021", Title: "The Messenger", Author: "Lois Lowry", Status: "Available", Action: "Available"}
    ];

    const CatalogList = document.getElementById('TBody');

    LessonCatalog.forEach(function(LessonList){
        const LessonTableRow = document.createElement('tr');

        const LessonID = document.createElement('td');
        LessonID.textContent = `#${LessonList.ID}`;
        LessonTableRow.appendChild(LessonID);

        const LessonTitle = document.createElement('td');
        LessonTitle.textContent = `${LessonList.Title}`;
        LessonTableRow.appendChild(LessonTitle);

        const LessonAuthor = document.createElement('td');
        LessonAuthor.textContent = `${LessonList.Author}`;
        LessonTableRow.appendChild(LessonAuthor);

        const LessonStatus = document.createElement('td');
        LessonStatus.textContent = `${LessonList.Status}`;
        LessonTableRow.appendChild(LessonStatus);

        const LessonAction = document.createElement('td');
        const LessonActionBtn = document.createElement('button');
        LessonActionBtn.textContent = `${LessonList.Action}`; 
        if (LessonList.Action == "Not Available"){
            LessonActionBtn.className = 'not-edit-btn';
        }else{LessonActionBtn.className = 'edit-btn';};
        LessonAction.appendChild(LessonActionBtn);
        LessonTableRow.appendChild(LessonAction);

        CatalogList.appendChild(LessonTableRow);

    });

});

  