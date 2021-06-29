--高速决斗技能-爱即是伤
Duel.LoadScript("speed_duel_common.lua")
function c100730101.initial_effect(c)
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730101.skill)
end
function c100730101.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLED)
	e3:SetValue(c100730101.abdcon)
	e3:SetCondition(c100730101.damcon)
	e3:SetOperation(c100730101.damop)
	Duel.RegisterEffect(e3,tp)
	Duel.Hint(HINT_CARD,1-tp,100730101)
	local c=Duel.CreateToken(tp,19763315)
	Duel.SendtoDeck(c,nil,0,REASON_RULE)
	local d1=Duel.CreateToken(tp,31245780)
	Duel.SendtoDeck(d1,nil,0,REASON_RULE)
	local d2=Duel.CreateToken(tp,28378427)
	Duel.SendtoDeck(d2,nil,0,REASON_RULE)
	local sg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,19763315,31245780,28378427)
	local g=sg:SelectSubGroup(tp,aux.dncheck,false,2,2)
	Duel.SSet(tp,g)
	e:Reset()
end
function c100730101.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and tc:IsCode(78371393,4779091,31764700)
end
function c100730101.damop(e,tp,eg,ep,ev,re,r,rp) 
	local tc=Duel.GetAttacker()
	local bc=tc:GetBattleTarget()
	if bc:IsLocation(LOCATION_MZONE) and bc:IsType(TYPE_MONSTER) then
		local dam=bc:GetAttack()
		if dam<0 then dam=0 end
		Duel.Damage(1-tp,dam,REASON_RULE)
	end
end
function c100730101.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end