<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="config.DbHelper"%>
<%@page import="config.TMHelper"%>
<jsp:include page="header.jsp"></jsp:include>

<div class="container-fluid p-2">
	<div class="card shadow" style="min-height: 90vh">
		<div class="card-body">
			<jsp:include page="msg.jsp"></jsp:include>
			<a href="" class="btn btn-success btn-sm float-right"
				data-target="#adduser" data-toggle="modal"><i class="fa fa-plus"></i>
				Add New</a>
			<h4 class="p-2" style="border-bottom: 2px solid green;">Users</h4>
			<table class="table table-bordered table-sm">
				<thead>
					<tr>
						<th>ID</th>
						<th>User Name</th>
						<th>Email Id</th>
						<th>Gender</th>
						<th>Password</th>
						<th>Project</th>
						<th>Role</th>
						<th>Designation</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<%
						List<Map<String, String>> data = DbHelper.executeDQL("select * from users WHERE role!=? order by 1 desc", "A");
					for (Map<String, String> row : data) {
					%>
					<tr>
						<td><%=row.get("id")%></td>
						<td><img src="<%=row.get("photo")%>"
							style="width: 60px; height: 60px;"> <%=row.get("uname")%></td>
						<td><%=row.get("email")%></td>
						<td><%=row.get("gender").equals("M") ? "Male" : "Female"%></td>
						<td><%=row.get("pwd")%></td>
						<td><%=TMHelper.getProjectName(row.get("pid"))%></td>
						<td><%=row.get("role").equals("M") ? "Manager" : "Employee"%></td>
						<td><%=TMHelper.getMasterName(row.get("designation"))%></td>
						<td><button data-toggle="modal"
								data-target="#e<%=row.get("id")%>"
								class="btn btn-primary btn-sm">Edit</button>
							<div class="modal fade" id="e<%=row.get("id")%>">
								<div class="modal-dialog">
									<form class="modal-content" method="post" action="updateuser">
										<input type="hidden" name="id" value="<%=row.get("id")%>">
										<div class="modal-header">
											<h5>Edit User</h5>
										</div>
										<div class="modal-body">
											<div class="form-group form-row">
												<label class="col-sm-4">User Name</label>
												<div class="col-sm-8">
													<input type="text" name="uname" required
														value="<%=row.get("uname")%>"
														class="form-control form-control-sm">
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Email Id</label>
												<div class="col-sm-8">
													<input type="email" name="email" required
														value="<%=row.get("email")%>"
														class="form-control form-control-sm">
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Gender</label>
												<div class="col-sm-8">
													<select name="gender" class="form-control form-control-sm">
														<option
															<%=row.get("gender").equals("M") ? "selected" : ""%>
															value="M">Male</option>
														<option
															<%=row.get("gender").equals("F") ? "selected" : ""%>
															value="F">Female</option>
													</select>
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Date of Birth</label>
												<div class="col-sm-8">
													<input type="date" name="dob" value="<%=row.get("dob")%>"
														class="form-control form-control-sm">
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Role</label>
												<div class="col-sm-8">
													<select name="role" required
														class="form-control form-control-sm">
														<option <%=row.get("role").equals("M") ? "selected" : ""%>
															value="M">Manager</option>
														<option <%=row.get("role").equals("E") ? "selected" : ""%>
															value="E">Employee</option>
													</select>
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Designation</label>
												<div class="col-sm-8">
													<select name="designation" required
														class="form-control form-control-sm">
														<%
														for (Map<String, String> sts : TMHelper.getMastersList("Designation")) {
													%>
														<option
															<%=row.get("designation").equals(sts.get("id")) ? "selected" : ""%>
															value="<%=sts.get("id")%>"><%=sts.get("mastername")%></option>
														<%
														}
													%>
													</select>
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Password</label>
												<div class="col-sm-8">
													<input type="password" required name="pwd"
														value="<%=row.get("pwd")%>"
														class="form-control form-control-sm">
												</div>
											</div>
											<div class="form-group form-row">
												<label class="col-sm-4">Repeat Password</label>
												<div class="col-sm-8">
													<input type="password" required value="<%=row.get("pwd")%>"
														name="cpwd" class="form-control form-control-sm">
												</div>
											</div>
										</div>
										<div class="modal-footer">
											<input type="submit" value="Save User"
												class="btn btn-primary btn-sm">
										</div>
									</form>
								</div>
							</div></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="modal fade" id="adduser">
	<div class="modal-dialog">
		<form class="modal-content" method="post" action="adduser"
			enctype="multipart/form-data">
			<div class="modal-header">
				<h5>Add User</h5>
			</div>
			<div class="modal-body">
				<div class="form-group form-row">
					<label class="col-sm-4">User Name</label>
					<div class="col-sm-8">
						<input type="text" name="uname" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Email Id</label>
					<div class="col-sm-8">
						<input type="email" name="email" required
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Gender</label>
					<div class="col-sm-8">
						<select name="gender" class="form-control form-control-sm">
							<option value="M">Male</option>
							<option value="F">Female</option>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Date of Birth</label>
					<div class="col-sm-8">
						<input type="date" name="dob" class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Role</label>
					<div class="col-sm-8">
						<select name="role" required class="form-control form-control-sm">
							<option value="">--- Select Role ---</option>
							<option value="M">Manager</option>
							<option value="E">Employee</option>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Designation</label>
					<div class="col-sm-8">
						<select name="designation" required
							class="form-control form-control-sm">
							<option value="">--- Select Designation ---</option>
							<%
								for (Map<String, String> sts : TMHelper.getMastersList("Designation")) {
							%>
							<option value="<%=sts.get("id")%>"><%=sts.get("mastername")%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Project</label>
					<div class="col-sm-8">
						<select name="pid" required
							class="form-control form-control-sm">
							<%
								List<Map<String,String>> projects=DbHelper.executeDQL("SELECT * FROM projects WHERE 1=?", "1");
								for (Map<String, String> pr : projects) {
							%>
							<option value="<%=pr.get("id")%>"><%=pr.get("title")%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Password</label>
					<div class="col-sm-8">
						<input type="password" required name="pwd"
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Repeat Password</label>
					<div class="col-sm-8">
						<input type="password" required name="cpwd"
							class="form-control form-control-sm">
					</div>
				</div>
				<div class="form-group form-row">
					<label class="col-sm-4">Photo</label>
					<div class="col-sm-8">
						<input type="file" name="photo"
							class="form-control-sm form-control-file">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<input type="submit" value="Save User"
					class="btn btn-primary btn-sm">
			</div>
		</form>
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>