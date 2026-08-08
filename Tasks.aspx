<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="CRM_PROJECT.Tasks" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Tasks | CRM System</title>
  <link rel="stylesheet" href="css/pages/tasks.css" />
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
      <h4 class="mb-0">Task Management</h4>
      <span class="text-muted">Create, assign, and monitor tasks</span>
    </div>
    <button
      type="button"
      class="btn btn-primary btn-sm"
      data-bs-toggle="modal"
      data-bs-target="#addTaskModal"
    >
      <i class="bx bx-plus me-1"></i>Add Task
    </button>
  </div>

  <div class="row g-4 mb-2">
    <div class="col-md-4">
      <div class="card">
        <div
          class="card-header d-flex justify-content-between align-items-center"
        >
          <h6 class="mb-0">Pending</h6>
          <span class="badge bg-label-secondary">2</span>
        </div>
        <div class="card-body d-flex flex-column gap-2">
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Send proposal to Nova Traders</p>
              <small class="text-muted">Due: 18 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  AK
                </div>
                <span class="badge badge-lead-lost">High</span>
              </div>
            </div>
          </div>
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Follow up with Karan Mehta</p>
              <small class="text-muted">Due: 19 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  PP
                </div>
                <span class="badge badge-lead-contacted">Medium</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card">
        <div
          class="card-header d-flex justify-content-between align-items-center"
        >
          <h6 class="mb-0">In Progress</h6>
          <span class="badge bg-label-secondary">3</span>
        </div>
        <div class="card-body d-flex flex-column gap-2">
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Prepare quarterly report</p>
              <small class="text-muted">Due: 20 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  RN
                </div>
                <span class="badge badge-lead-lost">High</span>
              </div>
            </div>
          </div>
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Update customer records</p>
              <small class="text-muted">Due: 21 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  SR
                </div>
                <span class="badge badge-lead-qualified">Low</span>
              </div>
            </div>
          </div>
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Onboard new lead - Bluewave</p>
              <small class="text-muted">Due: 22 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  AK
                </div>
                <span class="badge badge-lead-contacted">Medium</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card">
        <div
          class="card-header d-flex justify-content-between align-items-center"
        >
          <h6 class="mb-0">Completed</h6>
          <span class="badge bg-label-secondary">2</span>
        </div>
        <div class="card-body d-flex flex-column gap-2">
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Call Sanjay Desai</p>
              <small class="text-muted">Due: 15 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  PP
                </div>
                <span class="badge badge-lead-qualified">Low</span>
              </div>
            </div>
          </div>
          <div class="card crm-stat-card">
            <div class="card-body p-3">
              <p class="mb-1 fw-medium">Send welcome email to Bluewave</p>
              <small class="text-muted">Due: 16 Jul</small>
              <div
                class="d-flex justify-content-between align-items-center mt-2"
              >
                <div
                  class="crm-avatar-sm"
                  style="width: 26px; height: 26px; font-size: 10px"
                >
                  SR
                </div>
                <span class="badge badge-lead-contacted">Medium</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="addTaskModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Task</h5>
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
                <label class="form-label">Task Title</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="e.g. Send proposal to client"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Due Date</label>
                <input type="date" class="form-control" placeholder="" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Assigned To</label>
                <select class="form-select">
                  <option>Amit Kumar</option>
                  <option>Priya Patel</option>
                  <option>Rahul Nair</option>
                  <option>Sneha Rao</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Priority</label>
                <select class="form-select">
                  <option>Low</option>
                  <option>Medium</option>
                  <option>High</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option>Pending</option>
                  <option>In Progress</option>
                  <option>Completed</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Related Customer</label>
                <select class="form-select">
                  <option>Nova Traders</option>
                  <option>Zen Retail</option>
                  <option>Bluewave Inc</option>
                  <option>Orion Ltd</option>
                </select>
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
          <button type="button" class="btn btn-primary">Add Task</button>
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
  <script src="js/pages/tasks.js"></script>
</asp:Content>

