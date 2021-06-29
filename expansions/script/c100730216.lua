--高速决斗技能-飞蛾扑火
Duel.LoadScript("speed_duel_common.lua")
function c100730216.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730216.operation,c100730216.con,aux.Stringid(100730216,0))
	aux.SpeedDuelBeforeDraw(c,c100730216.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730216.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
end

function c100730216.operation(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,58192742)
	local g1=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil)
	local c=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_CARD,1-tp,100730216)
	Duel.SendtoDeck(c,nil,1,REASON_RULE)
	local op=Duel.SelectOption(tp,aux.Stringid(100730216,1),aux.Stringid(100730216,2))
	if op==0 and g:GetCount()>0 and Duel.GetMZoneCount(tp)>0 and Duel.IsPlayerCanSpecialSummon(tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,58192742)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(tc)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(aux.imval1)
			e1:SetOwnerPlayer(tp)
			tc:RegisterEffect(e1,true)
			Duel.SpecialSummonComplete()
			local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,40240595)
			if g2:GetCount()==0 then return end
			local qc=g2:GetFirst()
			if not qc then return end
			Duel.SendtoHand(qc,tp,REASON_RULE)
		end
	elseif op==1 then
		local g=Group.CreateGroup()
		local c=Duel.CreateToken(tp,48579379)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,14141448)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		c=Duel.CreateToken(tp,87756343)
		g:AddCard(c)
		aux.CardAddedBySkill:AddCard(c)
		Duel.SendtoHand(g,tp,REASON_RULE)
		local g1=g:RandomSelect(tp,2)
		Duel.Exile(g1,REASON_RULE)
	end
end

function c100730216.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730216.mothfilter)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730216.mothfilter(e,c)
	return c:IsCode(58192742,87756343,14141448,48579379) and c:IsFaceup()
end