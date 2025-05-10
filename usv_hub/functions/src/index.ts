import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

initializeApp();
const db = getFirestore();

export const generateAttendanceOnCourseCreation = onDocumentCreated("Course/{courseId}", async (event) => {
    const courseData = event.data?.data();
    const courseId = event.params.courseId;
    const semesterId = courseData!.SemesterId;

    if (!semesterId) {
        console.error("Missing semesterId");

        return;
    }

    const studentsSnapshot = await db
        .collection("SemesterXStudent")
        .where("SemesterId", "==", semesterId)
        .where("IsActive", "==", true)
        .get();

    const batch = db.batch();

    studentsSnapshot.forEach((doc) => {
        const data = doc.data();
        const attendanceRef = db.collection("Attendance").doc();

        batch.set(attendanceRef, {
            CourseId: courseId,
            StudentId: data.StudentId,
            CourseAttendance: {},
            LaboratoryAttendance: {},
            IsActive: true,
            id: attendanceRef.id,
        });
    });

    await batch.commit();
    console.log(`Attendance created for ${studentsSnapshot.size} students`);
});
