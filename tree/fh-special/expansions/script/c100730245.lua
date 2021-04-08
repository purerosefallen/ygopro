--高速决斗技能-未来视界
Duel.LoadScript("speed_duel_common.lua")
function c100730245.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730245.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730245.filter(c,g)
	if not c:IsSetCard(0x31) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730245.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730245.filter,tp,LOCATION_DECK+LOCATION_HAND,0,5,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730245,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	Duel.PayLPCost(1-tp,1500)
	Duel.Hint(HINT_CARD,1-tp,100730245)
	local cn=Duel.CreateToken(tp,87902575)
	Duel.MoveToField(cn,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	local c=Duel.CreateToken(tp,56256517)
	Duel.SendtoHand(c,tp,REASON_RULE)
	e:Reset()
end