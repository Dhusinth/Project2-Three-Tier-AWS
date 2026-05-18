async function checkServices() {

    const backendStatus = document.getElementById("backend-status");

    const dbStatus = document.getElementById("db-status");

    try {

        const backendResponse = await fetch("/api/health");

        const backendData = await backendResponse.json();

        backendStatus.innerText =
            "Status: " + backendData.status;

    } catch (error) {

        backendStatus.innerText = "Backend Unreachable";
    }

    try {

        const dbResponse = await fetch("/api/db-check");

        const dbData = await dbResponse.json();

        dbStatus.innerText =
            "Database: " + dbData.database;

    } catch (error) {

        dbStatus.innerText = "Database Connection Failed";
    }
}

checkServices();

setInterval(checkServices, 10000);