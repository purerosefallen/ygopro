function aux.RegisterSpeedDuelSkillCardCommon()
	if aux.speed_skill_reg then return end

	aux.speed_skill_reg = true

	local orig_announce=Duel.AnnounceCard
	Duel.AnnounceCard=
		function(tp,typ)
			if not typ then typ=TYPE_MONSTER|TYPE_SPELL|TYPE_TRAP end
			local code=orig_announce(tp,typ)
			while code>100730000 and code<100740000 do
				code=orig_announce(tp,typ)
			end
		end
	
	aux.ExiledSpeedDuelSkillCardCount={}
	aux.ExiledSpeedDuelSkillCardCount[0]=0
	aux.ExiledSpeedDuelSkillCardCount[1]=0
	aux.SpeedDuelSkillRegisterTurn={}
	aux.CardAddedBySkill=Group.CreateGroup()
	aux.CardAddedBySkill:KeepAlive()
	aux.SpeedDuelMainPhaseSkillOperations={}
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(aux.SpeedDuelExileCard)
	Duel.RegisterEffect(e1,0,true)
end
function aux.IsSpeedDuelSkillCard(c)
	return c:GetOriginalCode()<100730000 and c:GetOriginalCode()>100740000 and not aux.CardAddedBySkill:IsContains(c)
end
function aux.IsSpeedDuelSkillCardExile(c)
	return c:GetOriginalCode()>100730000 and c:GetOriginalCode() < 100740000
end
function aux.SpeedDuelExileCard(e,tp,eg,ep,ev,re,r,rp)
	if not aux.CheckedIsTag then
		aux.CheckedIsTag = true
		if Duel.GetLP(0) > 8001 then
			aux.IsTag = true
		end
	end
	local g=Duel.GetMatchingGroup(aux.IsSpeedDuelSkillCardExile,0,LOCATION_EXTRA,0,nil)
	if g then
		g:ForEach(aux.SpeedDuelRegisterTurn)
		if g:GetCount()>1 then
			Duel.SetLP(0,0)
			return
		end
		if aux.SpeedDuelDontExile then
			g:Sub(aux.SpeedDuelDontExile)
		end
		Duel.Exile(g,REASON_RULE)
	end
	g=Duel.GetMatchingGroup(aux.IsSpeedDuelSkillCardExile,0,0,LOCATION_EXTRA,nil)
	if g then
		g:ForEach(aux.SpeedDuelRegisterTurn)
		if g:GetCount()>1 then
			Duel.SetLP(1,0)
			return
		end
		if aux.SpeedDuelDontExile then
			g:Sub(aux.SpeedDuelDontExile)
		end
		Duel.Exile(g,REASON_RULE)
	end
	--if Duel.IsExistingMatchingCard(aux.NotSpeedDuelSkillCard,0,LOCATION_EXTRA,0,7,nil) then Duel.SetLP(0,0) end
	--if Duel.IsExistingMatchingCard(aux.NotSpeedDuelSkillCard,1,LOCATION_EXTRA,0,7,nil) then Duel.SetLP(1,0) end
end
function aux.SpeedDuelRegisterTurn(c)
	aux.SpeedDuelSkillRegisterTurn[c]=Duel.GetTurnCount()
end
function aux.SpeedDuelMoveCardToFieldCommon(id,c)
	--activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetOperation(aux.SpeedDuelMoveCardToFieldCommonOperation)
	e1:SetLabel(id)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0)
end
function aux.SpeedDuelMoveCardToFieldCommonOperation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	if (c:IsType(TYPE_MONSTER)) then
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	else
		if c:IsType(TYPE_FIELD) then
			Duel.MoveToField(c,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		else
			Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
	e:Reset()
end
function aux.SpeedDuelBeforeDraw(c,op)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e1:SetOperation(op)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0,true)
end
function aux.SpeedDuelMoveCardToDeckCommon(id,c)
	if not aux.Redraw then
		aux.Redraw={}
		aux.Redraw[0]=true
		aux.Redraw[1]=true
	end
	--activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e1:SetOperation(aux.SpeedDuelMoveCardToDeckCommonOperation)
	e1:SetLabel(id)
	e1:SetLabelObject(c)
	Duel.RegisterEffect(e1,0,true)
	--activate
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetOperation(aux.SpeedDuelRedraw)
	e2:SetLabelObject(c)
	Duel.RegisterEffect(e2,0,true)
end
function aux.SpeedDuelMoveCardToDeckCommonOperation(e,tp,eg,ep,ev,re,r,rp)
	local id=e:GetLabel()
	tp = e:GetLabelObject():GetOwner()
	local c=Duel.CreateToken(tp,id)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,nil,2,REASON_RULE)
	if c:GetLocation()&LOCATION_DECK then
		aux.Redraw[tp]=false
	end
	aux.CardAddedBySkill:AddCard(c)
	e:Reset()
end
function aux.SpeedDuelRedraw(e,tp,eg,ep,ev,re,r,rp)
	tp = (e:GetLabelObject()):GetOwner()
	if aux.Redraw[tp] then return end
	aux.Redraw[tp]=true

	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_HAND,0,nil)
	local count=aux.SpeedDuelSendToDeckWithExile(tp,g)

	local g3=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
	g3=g3:RandomSelect(tp,count)
	aux.SpeedDuelSendToHandWithExile(tp,g3)

	e:Reset()
end
function aux.SpeedDuelSendToHandWithExile(tp,g)
	if not g then return 0 end
	local count=0
	local g2=Group.CreateGroup()
	if aux.GetValueType(g)=="Card" then
		g=Group.FromCards(g)
	end
	local c=g:GetFirst()
	while c do
		local tc=Duel.CreateToken(tp,c:GetOriginalCode())
		count=count+1
		g2:AddCard(tc)
		c=g:GetNext()
	end
	Duel.Exile(g,REASON_RULE)
	Duel.SendtoHand(g2,nil,REASON_RULE)
	return count
end
function aux.SpeedDuelSendToDeckWithExile(tp,g)
	if not g then return 0 end
	local g2=Group.CreateGroup()
	local count=0
	if aux.GetValueType(g)=="Card" then
		g=Group.FromCards(g)
	end
	local c=g:GetFirst()
	while c do
		local tc=Duel.CreateToken(tp,c:GetOriginalCode())
		count=count+1
		g2:AddCard(tc)
		c=g:GetNext()
	end
	Duel.Exile(g,REASON_RULE)
	Duel.SendtoDeck(g2,nil,-1,REASON_RULE)
	return count
end
function aux.SpeedDuelAtMainPhase(c,op,con,desc)
	if not aux.SpeedDuelDontExile then aux.SpeedDuelDontExile=Group.CreateGroup() end
	aux.SpeedDuelDontExile:KeepAlive()
	aux.SpeedDuelDontExile:AddCard(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetDescription(desc)
	e1:SetCountLimit(1,c:GetOriginalCode())
	if con then
		e1:SetCondition(con)
	else
		e1:SetCondition(aux.SpeedDuelAtMainPhaseCondition)
	end
	e1:SetLabelObject(c)
	e1:SetOperation(op)
	Duel.RegisterEffect(e1,0)
	local e2=e1:Clone()
	Duel.RegisterEffect(e2,1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_CANNOT_REMOVE)
	e3:SetRange(LOCATION_EXTRA)
	c:RegisterEffect(e3)
end
function aux.SpeedDuelAtMainPhaseCondition(e,tp)
	tp=(e:GetLabelObject()):GetOwner()
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentChain()==0 and Duel.GetCurrentPhase()==PHASE_MAIN1
end