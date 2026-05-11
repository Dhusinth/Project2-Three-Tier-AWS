async function checkHealth() {

    const result = document.getElementById("result");

    try {

        const response = await fetch("/api/health");

        const data = await response.json();

        result.innerText = "Backend Status: " + data.status;

    } catch (error) {

        result.innerText = "Backend connection failed";

    }
}