<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Notes.aspx.cs" Inherits="CRM_PROJECT.Notes" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Customer Notes | CRM System</title>
  <link rel="stylesheet" href="css/pages/notes.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div
    class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2"
  >
    <div>
      <h4 class="mb-0">Customer Notes</h4>
      <span class="text-muted"
        >Store customer interaction and meeting notes</span
      >
    </div>
    <button
      type="button"
      class="btn btn-primary btn-sm"
      data-bs-toggle="modal"
      data-bs-target="#addNoteModal"
    >
      <i class="bx bx-plus me-1"></i>Add Note
    </button>
  </div>

  <div class="row g-4">
    <div class="col-md-6">
      <div class="card h-100">
        <div class="card-header">
          <h6 class="mb-0">Recent Notes</h6>
        </div>
        <div class="card-body">
          <div class="d-flex flex-column gap-3">
            <div class="border rounded p-3">
              <p class="mb-1 fw-medium">
                Customer requested follow-up on proposal review
              </p>
              <small class="text-muted">By Admin User • 2 hours ago</small>
            </div>
            <div class="border rounded p-3">
              <p class="mb-1 fw-medium">Meeting notes with BrightEdge team</p>
              <small class="text-muted">By Team Lead • Yesterday</small>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-6">
      <div class="card h-100">
        <div class="card-header">
          <h6 class="mb-0">Add New Note</h6>
        </div>
        <div class="card-body">
          <div class="mb-3">
            <label class="form-label">Customer</label>
            <input type="text" class="form-control" value="Ritika Shah" />
          </div>
          <div class="mb-3">
            <label class="form-label">Note</label>
            <textarea class="form-control" rows="6">
Discussed pricing, implementation timeline, and follow-up call for next Monday.</textarea
            >
          </div>
          <button class="btn btn-primary">Save Note</button>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="addNoteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Note</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Customer</label>
                <select class="form-select">
                  <option>Ritika Shah</option>
                  <option>Karan Mehta</option>
                  <option>Priya Patel</option>
                  <option>Sanjay Desai</option>
                  <option>Meera Joshi</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Note</label>
                <textarea
                  class="form-control"
                  rows="4"
                  placeholder="Write the interaction / meeting note..."
                ></textarea>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-label-secondary"
            data-bs-dismiss="modal"
          >
            Cancel
          </button>
          <button type="button" class="btn btn-primary">Add Note</button>
        </div>
      </div>
    </div>
  </div>
</asp:Content>

<asp:Content
  ID="ScriptContent"
  ContentPlaceHolderID="ContentPlaceHolder3"
  runat="server"
>
</asp:Content>

