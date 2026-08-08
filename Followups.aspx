<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Followups.aspx.cs" Inherits="CRM_PROJECT.Followups" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Follow-Ups | CRM System</title>
  <link rel="stylesheet" href="css/pages/followups.css" />
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
      <h4 class="mb-0">Follow-Up Management</h4>
      <span class="text-muted">Schedule and track customer follow-ups</span>
    </div>
  </div>

  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h6 class="mb-0">Upcoming Follow-Ups</h6>
      <button
        type="button"
        class="btn btn-sm btn-primary"
        data-bs-toggle="modal"
        data-bs-target="#scheduleFollowupModal"
      >
        New Follow-Up
      </button>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table crm-table">
          <thead>
            <tr>
              <th>Customer</th>
              <th>Follow-up Date</th>
              <th>Owner</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Ritika Shah</td>
              <td>18 Jul, 11:00 AM</td>
              <td>Admin</td>
              <td><span class="badge badge-lead-new">Scheduled</span></td>
            </tr>
            <tr>
              <td>Karan Mehta</td>
              <td>19 Jul, 02:00 PM</td>
              <td>Team Lead</td>
              <td><span class="badge badge-lead-contacted">Pending</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div
    class="modal fade"
    id="scheduleFollowupModal"
    tabindex="-1"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Schedule Follow-Up</h5>
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
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Type</label>
                <select class="form-select">
                  <option>Call</option>
                  <option>Email</option>
                  <option>Meeting</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Date</label>
                <input type="date" class="form-control" placeholder="" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Time</label>
                <input type="time" class="form-control" placeholder="" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Assigned To</label>
                <select class="form-select">
                  <option>Amit Kumar</option>
                  <option>Priya Patel</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Notes</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Optional notes"
                />
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
          <button type="button" class="btn btn-primary">Schedule</button>
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


